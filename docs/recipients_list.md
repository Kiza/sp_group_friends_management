# Recipients list

## API
```
GET /message/recipients
```

## Input
```
{
  "sender":  "john@example.com",
  "text": "Hello World! kate@example.com"
}
```

## Success output
```
{
  "success": true
  "recipients":
    [
      "lisa@example.com",
      "kate@example.com"
    ]
}
```

## Notes:
- No error output
- All input will be treated as valid
- Invalid input will cause zero friend returned