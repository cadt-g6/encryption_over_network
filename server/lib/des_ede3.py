# Mode - encrypt or decrypt (E/d): e
# Input password: 1234567
# Input plain text: 1234567876543

# Ouput:
# -------------------------------------
# Cipher Text: YY/ZsZia+mHzzgVFrCKbsQ==
# Plain Text: 1234567876543
# -------------------------------------

from Crypto.Cipher import DES
import base64


class DesEde3:
    def __init__(self) -> None:
        pass

    # debug
    def byte_to_arr(byte):
        return list(bytearray(byte))

    def encrypt(self, plain_text: str, key: str) -> str:
        encoded_key = self.encode_key(key)
        crypter = DES.new(encoded_key, DES.MODE_ECB)

        plain_text += '\x00' * (8 - len(plain_text) % 8)
        encrypted = crypter.encrypt(plain_text.encode('ascii'))
        cipter_base64 = base64.b64encode(encrypted).decode("utf-8")

        return cipter_base64

    def decrypt(self, cipher_text: str, key: str) -> str:
        encoded_key = self.encode_key(key)
        crypter = DES.new(encoded_key, DES.MODE_ECB)

        cipter_base64 = base64.b64decode(cipher_text)
        plain_text = crypter.decrypt(cipter_base64)
        decode_str = plain_text.decode('utf-8')

        return decode_str

    def encode_key(self, key: str):
        # salt = '\x28\xAB\xBC\xCD\xDE\xEF\x00\x33'
        # key = password + salt
        # m = hashlib.md5(key.encode('utf-8'))
        # return m.digest()
        return key.encode('utf-8')[0:8]
