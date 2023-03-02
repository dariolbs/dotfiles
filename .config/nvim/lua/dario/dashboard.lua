require('dashboard').setup {
      theme = 'doom',
  config = {
  header = {
      [[]],
      [[]],
      [[]],
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      [[]],
      [[]],
      [[]],
  },
  center = {
    {
      icon = '󰭎 ',
      desc = 'Search Project',
      key = 'f',
      action = 'Telescope find_files'
    },
    {
      icon = ' ',
      desc = 'Search Notes',
      key = 'n',
      action = 'cd ~/Documents/Notas | Telescope find_files'
    },
    {
      icon = ' ',
      desc = 'Search Config',
      key = 'd',
      action = 'cd ~/.config/nvim/lua | Telescope find_files'
    },
  },
  footer = {}  --your footer
}
  }
