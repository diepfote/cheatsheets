#!/usr/bin/env python3

from jinja2 import Environment, FileSystemLoader

import os

# Load jinja template file
TEMPLATE_FILE = 'template.j2'
template_loader = FileSystemLoader(searchpath=os.path.dirname(__file__))
template_env = Environment(loader=template_loader)
template = template_env.get_template(TEMPLATE_FILE)
print(template.render(command='blub', build_output_dir='123', version_9=True))
print('---')
print(template.render(command='blub', build_output_dir='a/long/path/that/Imightwanttocut', version_9=False))
print('---')
print(template.render(command='', build_output_dir='123', version_9=False))
