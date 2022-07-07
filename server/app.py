# flask run -p 5001

from cgi import FieldStorage
import flask
from flask import jsonify, request, send_file
from lib.des_ede3 import DesEde3
from lib.des_ede3_file import DesEde3File

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

@app.route('/encrypted_image', methods=['GET'])
def encrypted_image():
    des_ede3 = DesEde3File(key="1234567890" * 2)
    encrypted = des_ede3.encrypt('image.jpeg')
    return send_file(encrypted, attachment_filename='image.jpeg')

@app.route('/decrypted_image', methods=['POST'])
def decrypted_image():
    result = request.files['body']
    des_ede3 = DesEde3File(key="1234567890" * 2)
    reader = result.read()
    
    encrypted_file = open("encrypted.jpeg", mode="wb")
    with encrypted_file as ef:
        ef.write(reader)
    
    des_ede3.decrypt('encrypted.jpeg')
    return "GREAT"

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
