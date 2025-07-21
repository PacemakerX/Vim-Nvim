local M = {}

local timer = nil
local win = nil
local buf = nil
local seconds = 0
local countdown = false
local countdown_start = 0

-- Beep sound
local function beep()
  vim.fn.jobstart({ "paplay", "/usr/share/sounds/freedesktop/stereo/complete.oga" }, { detach = true })
end

-- Reset everything when timer ends/stops
local function reset_state()
  if timer then
    timer:stop()
    timer:close()
    timer = nil
  end

  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end

  win = nil
  buf = nil
  seconds = 0
  countdown = false
  countdown_start = 0
end

-- Shared start logic
local function start(opts)
  if timer then
    vim.notify("Timer already running", vim.log.levels.WARN)
    return
  end

  opts = opts or {}
  countdown = opts.countdown or false
  countdown_start = opts.duration or 0
  seconds = countdown and countdown_start or 0

  buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = 20,
    height = 1,
    row = 1,
    col = vim.o.columns - 22,
    anchor = "NW",
    style = "minimal",
    border = "rounded",
  })

  timer = vim.loop.new_timer()
  timer:start(0, 1000, vim.schedule_wrap(function()
    if countdown then
      seconds = seconds - 1
    else
      seconds = seconds + 1
    end

    local mins = math.floor(seconds / 60)
    local secs = math.abs(seconds % 60)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      string.format(countdown and "⏳ %02d:%02d" or "⏱️  %02d:%02d", mins, secs)
    })

    -- Countdown hits 0
    if countdown and seconds <= 0 then
      beep()
      vim.notify("⏱️ Time's up!", vim.log.levels.ERROR)
      reset_state()
    end
  end))

  -- Notify only at start (for countdown)
  if countdown then
    vim.notify("⏳ Countdown started", vim.log.levels.INFO)
  end
end

-- Stopwatch mode
function M.start_stopwatch()
  start({ countdown = false })
end

-- Countdown mode
function M.start_countdown(minutes)
  local duration = tonumber(minutes or 90) * 60
  start({ countdown = true, duration = duration })
end

-- Manual stop
function M.stop_timer()
  if timer then
    beep()      
    reset_state()
    vim.notify("⏹️ Timer stopped", vim.log.levels.INFO)
  else
    vim.notify("No active timer", vim.log.levels.WARN)
  end
end

return M
