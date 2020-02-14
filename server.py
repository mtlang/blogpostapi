from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

@app.route('/post', methods=['POST'])
def post_post():
    return request.json

@app.route('/posts', methods=['GET'])
def get_posts():
    result = [] # the return value (the response body)

    # connect to the database
    connection = sqlite3.connect('blog.db')
    cursor = connection.cursor()

    # add a dictionary to the output for each row
    for row in cursor.execute("SELECT * FROM posts"):
        blog_post = {
            "post_id": row[0],
            "title": row[1],
            "body": row[2]
        }
        result.append(blog_post)

    # return the result
    return jsonify(result)
