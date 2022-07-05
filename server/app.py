# flask run -p 5001

import flask
from flask import jsonify, request
from sqlalchemy import null

from lib.des_ede3 import DesEde3

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "HI THERE"

# :text, :encrypt
@app.route('/des-ede3', methods=['POST'])
def des_ede3():
    des_ede3 = DesEde3()
    json = request.json
    
    text:str = json['text']
    encrypt: bool = json['encrypt'] == "true"
    
    cipher_text: str = None
    plain_text: str = None
    key: str = "1234567890" * 2
    
    if(encrypt):
        plain_text = text
        cipher_text = des_ede3.encrypt(text, key)
    else:
        plain_text = des_ede3.decrypt(text, key)
        cipher_text = text

    return jsonify({
        "cipher_text": cipher_text,
        "plain_text": plain_text,
    })


if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
