#!/usr/bin/env python

import json
import os


my_config = {
    'common': {
        #'term_truecolor': True,
        #'additional_escapes': 'tmux',
    },
    "ext": {
        "shell": {
            "theme": "default_leftonly",
        },
    },
}

my_shell_theme = {
    "segments": {
        "left": [
            {
                'module': 'powerline.segments.shell',
                'name': 'jobs',
            },
            {
                "name": "date",
                "args": {
                    "istime": True,
                    "format": "%H:%M:%S",
                },
            },
            { "name": "user" },
            { "name": "hostname" },
            { "name": "virtualenv" },
            { "name": "branch" },
            {
                "name": "cwd",
                "args": { "dir_limit_depth": 3 },
            },
            {
                "name": "last_status",
                "module": "powerline.segments.shell",
            },
        ]
    }
}

my_shell_colorscheme = {
    "groups": {
        "time": {
            "fg": "gray10",
            "bg": "gray2",
            "attr": ["bold"],
        },
        "time:divider": {
            "fg": "gray5",
            "bg": "gray2",
        },
    }
}

my_tmux_theme = {
    "segments": {
        "right": [],
    }
}


this_dir = os.path.dirname(os.path.abspath(__file__))


def merge_dict(base_dict, extra_dict):
    for key, extra_value in extra_dict.iteritems():
        if key in base_dict and isinstance(extra_value, dict):
            merge_dict(base_dict[key], extra_value)
        else:
            base_dict[key] = extra_value


def merge_config(in_file_name, extra_config, out_file_name):
    with open(in_file_name) as in_file:
        config = json.load(in_file)
    merge_dict(config, extra_config)
    with open(out_file_name, 'w') as out_file:
        json.dump(config, out_file, indent=4, sort_keys=True)


merge_config(
    '%s/powerline/powerline/config_files/config.json' % this_dir,
    my_config,
    '%s/_config/powerline/config.json' % this_dir,
)

merge_config(
    '%s/powerline/powerline/config_files/themes/shell/default_leftonly.json' % this_dir,
    my_shell_theme,
    '%s/_config/powerline/themes/shell/default_leftonly.json' % this_dir,
)

merge_config(
    '%s/powerline/powerline/config_files/colorschemes/shell/default.json' % this_dir,
    my_shell_colorscheme,
    '%s/_config/powerline/colorschemes/shell/default.json' % this_dir,
)

merge_config(
    '%s/powerline/powerline/config_files/themes/tmux/default.json' % this_dir,
    my_tmux_theme,
    '%s/_config/powerline/themes/tmux/default.json' % this_dir,
)
