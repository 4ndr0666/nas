# HTTP Headers Cheat Sheet for Download Tools

This cheat sheet provides a quick reference for common and useful HTTP headers that can be used with download tools like `n-m3u8dl-re`. These headers help mimic browser requests, manage sessions, and handle other HTTP-specific tasks.

## Common HTTP Headers

### 1. **User-Agent**
   - **Description**: Mimics a specific browser or device.
   - **Example**:
     ```bash
     -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
     ```

### 2. **Referer**
   - **Description**: Identifies the source that referred the client to the resource.
   - **Example**:
     ```bash
     -H "Referer: https://example.com"
     ```

### 3. **Cookie**
   - **Description**: Carries session data or authentication tokens.
   - **Example**:
     ```bash
     -H "Cookie: sessionid=abc123; other_cookie=value"
     ```

### 4. **Authorization**
   - **Description**: Provides credentials for authenticating with a server.
   - **Example**:
     ```bash
     -H "Authorization: Bearer your_access_token"
     ```

### 5. **Origin**
   - **Description**: Specifies the origin of the request.
   - **Example**:
     ```bash
     -H "Origin: https://example.com"
     ```

### 6. **Accept-Language**
   - **Description**: Specifies the preferred languages for the response.
   - **Example**:
     ```bash
     -H "Accept-Language: en-US,en;q=0.9"
     ```

### 7. **X-Requested-With**
   - **Description**: Identifies the type of request (e.g., AJAX).
   - **Example**:
     ```bash
     -H "X-Requested-With: XMLHttpRequest"
     ```

### 8. **Range**
   - **Description**: Requests a specific part of a file, useful for resuming downloads.
   - **Example**:
     ```bash
     -H "Range: bytes=0-"
     ```

### 9. **Cache-Control**
   - **Description**: Directs caching behavior.
   - **Example**:
     ```bash
     -H "Cache-Control: no-cache"
     ```

### 10. **DNT (Do Not Track)**
   - **Description**: Indicates whether the user prefers not to be tracked.
   - **Example**:
     ```bash
     -H "DNT: 1"
     ```

## Additional Useful Headers

### 11. **Accept**
   - **Description**: Specifies the media types that are acceptable for the response.
   - **Example**:
     ```bash
     -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
     ```

### 12. **Accept-Encoding**
   - **Description**: Specifies the content encodings (like gzip) that are acceptable in the response.
   - **Example**:
     ```bash
     -H "Accept-Encoding: gzip, deflate, br"
     ```

### 13. **Accept-Charset**
   - **Description**: Specifies the character encodings that are acceptable.
   - **Example**:
     ```bash
     -H "Accept-Charset: utf-8, iso-8859-1;q=0.5"
     ```

### 14. **Connection**
   - **Description**: Controls whether the network connection stays open after the current transaction.
   - **Example**:
     ```bash
     -H "Connection: keep-alive"
     ```

### 15. **If-Modified-Since**
   - **Description**: Makes the request conditional: the server will send the requested resource only if it has been modified since the specified date.
   - **Example**:
     ```bash
     -H "If-Modified-Since: Wed, 21 Oct 2015 07:28:00 GMT"
     ```

### 16. **If-None-Match**
   - **Description**: Makes the request conditional: the server will send the requested resource only if the provided ETag does not match the current ETag value.
   - **Example**:
     ```bash
     -H "If-None-Match: \"e0023aa4e\""
     ```

### 17. **Pragma**
   - **Description**: HTTP/1.0 header used to include implementation-specific directives that might apply to any recipient along the request-response chain.
   - **Example**:
     ```bash
     -H "Pragma: no-cache"
     ```

### 18. **Upgrade-Insecure-Requests**
   - **Description**: Requests the server to upgrade to an HTTPS connection.
   - **Example**:
     ```bash
     -H "Upgrade-Insecure-Requests: 1"
     ```

### 19. **TE**
   - **Description**: Specifies the transfer encodings the client is willing to accept.
   - **Example**:
     ```bash
     -H "TE: trailers"
     ```

### 20. **Content-Type**
   - **Description**: Specifies the media type of the resource or the data being sent to the server.
   - **Example**:
     ```bash
     -H "Content-Type: application/json"
     ```

## Example: Combining Headers in a Command

```bash
n-m3u8dl-re "URL" \
    --save-name myvideo.mp4 \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0" \
    -H "Referer: https://example.com" \
    -H "Cookie: sessionid=abc123; other_cookie=value" \
    -H "Accept-Language: en-US,en;q=0.9" \
    -H "Cache-Control: no-cache" \
    -H "Connection: keep-alive"
```
