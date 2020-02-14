from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

@app.route('/post', methods=['POST'])
def post_post():
    return 'Hello, World!'

@app.route('/posts', methods=['GET'])
def get_posts():
    return 'Hello, World!'
