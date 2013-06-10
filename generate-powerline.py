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

this_dir = os.path.dirname(os.path.abspath(__file__))


def merge(base_dict, extra_dict):
    for key, extra_value in extra_dict.iteritems():
        if key in base_dict and isinstance(extra_value, dict):
            merge(base_dict[key], extra_value)
        else:
            base_dict[key] = extra_value


with open('%s/powerline/powerline/config_files/config.json' % this_dir) as default_file:
    config = json.load(default_file)
merge(config, my_config)
with open('%s/_config/powerline/config.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)


with open('%s/powerline/powerline/config_files/themes/shell/default_leftonly.json' % this_dir) as default_file:
    config = json.load(default_file)
merge(config, my_shell_theme)
with open('%s/_config/powerline/themes/shell/default_leftonly.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)

with open('%s/powerline/powerline/config_files/colorschemes/shell/default.json' % this_dir) as default_file:
    config = json.load(default_file)
merge(config, my_shell_colorscheme)
with open('%s/_config/powerline/colorschemes/shell/default.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)
