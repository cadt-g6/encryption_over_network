from Crypto.Cipher import AES

class AesFile:
    def __init__(self, key) -> None:
        self.encoded_key = self.encode_key(key)
        self.encrypted_path = "assets/encrypted.jpeg"
        self.decrypted_path = "assets/decrypted.jpeg"
        pass

    def crypter(self):
        return AES.new(
            self.encoded_key,
            AES.MODE_OFB,
            # nonce=b'0',
            iv=self.encoded_key,
        )

    # debug
    def byte_to_arr(self, byte):
        return list(bytearray(byte))

    def encrypt(self, file_path: str) -> str:
        file = open(file_path, mode='rb')

        byte_arr: bytes = file.read()
        arr = self.byte_to_arr(byte_arr)

        while (len(arr) % 16 != 0):
            arr.append(0)

        encrypted = self.crypter().encrypt(bytes(arr))

        encrypted_file = open(self.encrypted_path, mode="wb")
        with encrypted_file as ef:
            ef.write(encrypted)

        return self.encrypted_path

    def decrypt(self, file_path: str) -> str:
        file = open(file_path, mode="rb")

        byte_arr: bytes = file.read()
        decrypted: bytes = self.crypter().decrypt(byte_arr)
        arr = self.byte_to_arr(decrypted)

        while (arr[len(arr) - 1] == 0):
            arr.pop(len(arr) - 1)

        decrypted_file = open(self.decrypted_path, mode="wb")
        with decrypted_file as ef:
            ef.write(bytes(arr))

        return decrypted_file

    def encode_key(self, key: str):
        return key.encode('utf-8')[0:16]
