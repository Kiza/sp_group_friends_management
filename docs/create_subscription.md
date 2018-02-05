# Create subscription

## API
```
POST /subscription
```

## Input
```
{
  "requestor": "lisa@example.com",
  "target": "john@example.com"
}
```

## Success output
```
{
    "success": true,
}
```

## Failed output
```
{
    "success": false,
    "error": "<error message>"
}
```

## Error messages
- `Validation failed: By user is not a valid email address`
- `Validation failed: To user is not a valid email address`
- `Validation failed: To user has already been taken`
- `Validation failed: Not blocked is False`

## Notes:
- Email can subscribe to itself

