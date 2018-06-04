#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
IMDB Micro API
"""

from flask import Flask
from flask import Response

from imdb import IMDb
import sys

# imdb instance
ia = IMDb()

# flask instance
app = Flask(__name__)

print("Starting app...")

# routes
@app.route('/')
def index():
	resp = Response("OK")
	return resp

@app.route('/rating/<movie_id>')
def getRating(movie_id):

	print("Requesting rating for movie_id: " + movie_id)

	movie = ia.get_movie(movie_id)

	try:
		print("Got rating: " + str(movie['rating']))

		resp = Response(str(movie['rating']))

	except KeyError:

		print("Got invalid response: " + str(movie))

		resp = Response("0")

	return resp

# set port
port = int(sys.argv[1]) if len(sys.argv) > 1 else 80

# main
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=port, debug=True)
