# Mode - encrypt or decrypt (E/d): e
# Input password: 1234567
# Input plain text: 1234567876543

# Ouput:
# -------------------------------------
# Cipher Text: YY/ZsZia+mHzzgVFrCKbsQ==
# Plain Text: 1234567876543
# -------------------------------------

from Crypto.Cipher import DES3
import base64

class DesEde3:
    def __init__(self) -> None:
        pass

    # debug
    def byte_to_arr(self, byte):
        return list(bytearray(byte))

    def encrypt(self, plain_text: str, key: str) -> str:
        encoded_key = self.encode_key(key)
        crypter = DES3.new(encoded_key, DES3.MODE_ECB)

        plain_text += '\x00' * (8 - len(plain_text) % 8)
        encrypted: bytes = crypter.encrypt(plain_text.encode('ascii'))
        cipter_base64: bytes = base64.standard_b64encode(encrypted)

        return cipter_base64.decode("utf-8")

    def decrypt(self, cipher_text: str, key: str) -> str:
        encoded_key = self.encode_key(key)
        crypter = DES3.new(encoded_key, DES3.MODE_ECB)
        
        utf8 = cipher_text.encode('utf-8')
        cipher_base64 = base64.standard_b64decode(utf8)
        plain_text = crypter.decrypt(cipher_base64)
        
        return plain_text.decode('utf-8', errors='ignore')


    def encode_key(self, key: str):
        # salt = '\x28\xAB\xBC\xCD\xDE\xEF\x00\x33'
        # key = password + salt
        # m = hashlib.md5(key.encode('utf-8'))
        # return m.digest()
        return key.encode('utf-8')[0:16]