from os import environ

DEBUG               = True
VERSION             = "1.0"
AUTHOR              = "Dário Batista"
DEPENDENCIES_FILE   = f'{environ["HOME"]}/.config/installer/dependencies.conf'
DAEMONS_FILE        = f'{environ["HOME"]}/.config/installer/daemons.conf'
PACKAGE_LIST_DIR    = f'{environ["HOME"]}/.config/installer/package_lists'
PRE_SCRIPTS_DIR     = f'{environ["HOME"]}/.config/installer/pre_scripts'
POST_SCRIPTS_DIR    = f'{environ["HOME"]}/.config/installer/post_scripts'
