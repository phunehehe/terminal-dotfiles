#!/usr/bin/env python

import json
import os


my_config = {
    'common': {
        'term_truecolor': True
    }
}


def merge(base_dict, extra_dict):
    for key, extra_value in extra_dict.iteritems():
        if isinstance(extra_value, dict):
            merge(base_dict[key], extra_value)
        else:
            base_dict[key] = extra_value


this_dir = os.path.dirname(os.path.abspath(__file__))
with open('%s/powerline/powerline/config_files/config.json' % this_dir) as default_file:
    default_config = json.load(default_file)


config = default_config.copy()
merge(config, my_config)
with open('%s/_config/powerline/config.json' % this_dir, 'w') as config_file:
    json.dump(config, config_file, indent=4, sort_keys=True)
