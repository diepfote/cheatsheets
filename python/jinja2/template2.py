#!/usr/bin/env python3

from jinja2 import Environment, FileSystemLoader

import os

# Load jinja template file
TEMPLATE_FILE = 'template2.j2'
template_loader = FileSystemLoader(searchpath=os.path.dirname(__file__))
template_env = Environment(
            autoescape=False,
            loader=template_loader,
            trim_blocks=True,
            keep_trailing_newline=True,
)
template = template_env.get_template(TEMPLATE_FILE)
print(template.render(replica='blub'))
print('---')
print(template.render(replica=''))
