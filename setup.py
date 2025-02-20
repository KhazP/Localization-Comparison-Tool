from setuptools import setup, find_packages

setup(
    name="localizer",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        'pytest>=7.0.0',
        'pyyaml>=6.0.0',
        'colorama>=0.4.6',
        'gitpython>=3.1.0',
    ],
    entry_points={
        'console_scripts': [
            'compare_files=cli.compare_files:main',  # Points to cli/compare_files.py
        ]
    },
)
