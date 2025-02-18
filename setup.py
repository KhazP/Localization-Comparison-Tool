from setuptools import setup, find_packages

setup(
    name="localizer",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        'pytest>=7.0.0',
        'pyyaml>=6.0.0',
    ],
)
