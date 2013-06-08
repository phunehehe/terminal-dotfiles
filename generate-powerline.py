#!/usr/bin/env python

import json
import os


my_config = {
    'common': {
        #'term_truecolor': True,
        #'additional_escapes': 'tmux',
    }
}

my_theme_shell_default = {
    'segments': {
        'left': [
            { 'name': 'hostname' },
            { 'name': 'user' },
            { 'name': 'virtualenv' },
            {
                'name': 'cwd',
                'args': { 'dir_limit_depth': 3 },
            },
        ],
        'right': [
            {
                'module': 'powerline.segments.shell',
                'name': 'last_pipe_status',
            },
            {
                'module': 'powerline.segments.shell',
                'name': 'jobs',
            },
            { 'name': 'branch' },
        ]
    }
}

this_dir = os.path.dirname(os.path.abspath(__file__))


def merge(base_dict, extra_dict):
    for key, extra_value in extra_dict.iteritems():
        if isinstance(extra_value, dict):
            merge(base_dict[key], extra_value)
        else:
            base_dict[key] = extra_value


with open('%s/powerline/powerline/config_files/config.json' % this_dir) as default_file:
    config = json.load(default_file)

merge(config, my_config)
with open('%s/_config/powerline/config.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)


with open('%s/powerline/powerline/config_files/themes/shell/default.json' % this_dir) as default_file:
    config = json.load(default_file)

merge(config, my_theme_shell_default)
with open('%s/_config/powerline/themes/shell/default.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)
