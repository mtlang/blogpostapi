from flask import Flask, request, abort, jsonify
import sqlite3

app = Flask(__name__)

@app.errorhandler(400)
def bad_post_data(error):
    return jsonify(error=str(error)), 400

@app.route('/post', methods=['POST'])
def post_post():
    request_json = request.get_json()

    print(f'Recieved post request: {request_json}')

    # Input validation
    if request_json == None:
        abort(400, 'Request requires JSON data including a "title" and a "body".')

    if "title" not in request_json and "body" not in request_json:
        abort(400, 'Post must include a "title" and a "body".')
    elif "title" not in request_json:
        abort(400, 'Post must include a "title".')
    elif "body" not in request_json:
        abort(400, 'Post must include a "body".')

    # If we get to this point, we can extract the title and body from the request
    new_post_data = (request_json["title"], request_json["body"])

    # Connect to the database
    connection = sqlite3.connect('blog.db')
    
    connection.execute("INSERT INTO posts (title,body) VALUES(?,?)", new_post_data)

    return "Successfully posted", 201

@app.route('/posts', methods=['GET'])
def get_posts():
    result = [] # The return value (the response body)

    # Connect to the database
    connection = sqlite3.connect('blog.db')
    cursor = connection.cursor()

    # Add a dictionary to the output for each row
    for row in cursor.execute("SELECT * FROM posts"):
        blog_post = {
            "post_id": row[0],
            "title": row[1],
            "body": row[2]
        }
        result.append(blog_post)

    # Return the result
    return jsonify(result)
