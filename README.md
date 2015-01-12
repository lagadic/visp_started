# visp_started
Project given as an example based on ViSP third library available from  <http://team.inria.fr/lagadic/visp>.

## Prerequisities

This project hosted on Github <http://github.com/lagadic/visp_started> was designed to use ViSP as third party. Prior to build this project, the user has to download and install ViSP. A set of tutorials explaining how to install ViSP are available from <http://www.irisa.fr/lagadic/visp/publication.html#tutorial>

## How to build
Once ViSP is installed, download the source code from github:

	$ git clone git@github.com:lagadic/visp_started.git
	
Using cmake run:

	$ cd visp_started
	$ cmake .
	$ make

To generate the documentation you can run:

	make doc
