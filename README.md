# Send data over network
An assignment to encrypt message & image over network.
- Python as server
- Dart as frontend

## I. Structure

- Main of server can be found in [server/app.py](server/app.py)
- Main of frontend can be found in:
  - [frontend/exercise1.dart](frontend/exercise1.dart)
  - [frontend/exercise2.dart](frontend/exercise2.dart)

## II. Execute

### Server
You may need to install flask to run the project. To start server, execute following in terminal:

```s
flask run -p 5001
```

### Frontend
Make sure you start server first. To test frontend, execute following in terminal:

```s
# for exercise 1
dart --no-sound-null-safety exercise1.dart

# for exercise 2
dart --no-sound-null-safety exercise2.dart
```

## III. Team
See our team here: https://github.com/cadt-g6/encryption_over_network/graphs/contributors