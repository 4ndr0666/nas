## Commonly Used HTTP Headers (A to Z)

### A
- **Accept**: Specifies the media types that are acceptable for the response (e.g., `Accept: text/html`).
- **Accept-Charset**: Specifies the character sets that are acceptable (e.g., `Accept-Charset: utf-8`).
- **Accept-Encoding**: Specifies the encoding methods that are acceptable (e.g., `Accept-Encoding: gzip, deflate`).
- **Accept-Language**: Specifies the preferred languages for the response (e.g., `Accept-Language: en-US`).
- **Authorization**: Contains credentials for authenticating the user agent with a server (e.g., `Authorization: Bearer <token>`).

### B
- **Bearer**: Used for OAuth 2.0 authentication, included in the `Authorization` header (e.g., `Authorization: Bearer <token>`).
- **Beta-Session-Id**: Sometimes used for A/B testing or tracking sessions in beta features.

### C
- **Cache-Control**: Directives for caching mechanisms in both requests and responses (e.g., `Cache-Control: no-cache`).
- **Connection**: Controls whether the network connection stays open after the current transaction (e.g., `Connection: keep-alive`).
- **Content-Disposition**: Used to specify how the content should be handled by the client, such as inline display or download (e.g., `Content-Disposition: attachment; filename="file.txt"`).
- **Content-Encoding**: Used to specify the encoding used on the data (e.g., `Content-Encoding: gzip`).
- **Content-Language**: Describes the language(s) the content is in (e.g., `Content-Language: en`).
- **Content-Length**: The size of the body in bytes (e.g., `Content-Length: 348`).
- **Content-Location**: The location where the content was provided from (e.g., `Content-Location: /index.html`).
- **Content-Range**: Specifies where the provided content fits within the full body (e.g., `Content-Range: bytes 200-1000/67589`).
- **Content-Type**: Indicates the media type of the resource (e.g., `Content-Type: application/json`).
- **Cookie**: Contains stored HTTP cookies associated with the domain (e.g., `Cookie: sessionId=abc123`).

### D
- **Date**: The date and time when the message was sent (e.g., `Date: Tue, 15 Nov 1994 08:12:31 GMT`).
- **DNT (Do Not Track)**: Indicates the user’s tracking preference (e.g., `DNT: 1`).

### E
- **ETag**: A unique identifier for a specific version of a resource (e.g., `ETag: "123a456bc"`).
- **Expect**: Indicates that particular server behaviors are required by the client (e.g., `Expect: 100-continue`).
- **Expires**: Gives the date/time after which the response is considered stale (e.g., `Expires: Wed, 21 Oct 2021 07:28:00 GMT`).

### F
- **Forwarded**: Identifies the originating IP address of a client connecting through an HTTP proxy (e.g., `Forwarded: for=192.0.2.43`).

### G
- **Grant-Type**: Used in OAuth 2.0 authorization (e.g., `grant_type: password`).

### H
- **Host**: Specifies the domain name of the server (e.g., `Host: www.example.com`).

### I
- **If-Match**: Makes the request conditional by checking for a match with the ETag (e.g., `If-Match: "abc123"`).
- **If-Modified-Since**: Makes the request conditional by checking if the resource has been modified since a certain date (e.g., `If-Modified-Since: Wed, 21 Oct 2020 07:28:00 GMT`).
- **If-None-Match**: Makes the request conditional by checking if the ETag doesn't match (e.g., `If-None-Match: "abc123"`).
- **If-Range**: Requests only parts of a resource if it has not been modified since the given time (e.g., `If-Range: "abc123"`).
- **If-Unmodified-Since**: Makes the request conditional by checking if the resource has not been modified since a certain date (e.g., `If-Unmodified-Since: Wed, 21 Oct 2020 07:28:00 GMT`).

### J
- **Jwt-Authorization**: Used for JWT-based authentication (e.g., `Authorization: Bearer <jwt-token>`).

### K
- **Keep-Alive**: Controls how long the connection is kept alive (e.g., `Keep-Alive: timeout=5, max=100`).

### L
- **Last-Modified**: The date and time at which the resource was last modified (e.g., `Last-Modified: Wed, 21 Oct 2020 07:28:00 GMT`).
- **Location**: Used in redirection or to indicate the URL of a newly created resource (e.g., `Location: http://www.example.com/index.html`).

### M
- **Max-Forwards**: Limits the number of times a request can be forwarded (e.g., `Max-Forwards: 10`).

### N
- **Non-Authoritative-Reason**: Indicates the reason a response was not authoritative (e.g., `Non-Authoritative-Reason: Hinted`).

### O
- **Origin**: Indicates the origin of the cross-site request (e.g., `Origin: https://example.com`).

### P
- **Pragma**: Implementation-specific header that may have various effects along the request-response chain (e.g., `Pragma: no-cache`).
- **Proxy-Authorization**: Contains credentials to authenticate a user agent with a proxy server (e.g., `Proxy-Authorization: Basic YWxhZGRpbjpvcGVuc2VzYW1l`).

### Q
- **Query**: Custom header often used in API requests to query information (e.g., `Query: keyword=something`).

### R
- **Range**: Requests only part of an entity (e.g., `Range: bytes=500-999`).
- **Referer**: The address of the previous web page from which a link to the currently requested page was followed (e.g., `Referer: http://www.example.com/`).
- **Retry-After**: Indicates how long the user agent should wait before making a follow-up request (e.g., `Retry-After: 120`).

### S
- **Sec-Fetch-Dest**: Indicates the request’s destination (e.g., `Sec-Fetch-Dest: document`).
- **Sec-Fetch-Mode**: Indicates the mode of the request (e.g., `Sec-Fetch-Mode: navigate`).
- **Sec-Fetch-Site**: Indicates the site issuing the request (e.g., `Sec-Fetch-Site: same-origin`).
- **Sec-Fetch-User**: Indicates whether the request was triggered by user interaction (e.g., `Sec-Fetch-User: ?1`).
- **Server**: Contains information about the software used by the server (e.g., `Server: Apache/2.4.1`).
- **Set-Cookie**: Sends cookies from the server to the user agent (e.g., `Set-Cookie: sessionId=abc123; Path=/; HttpOnly`).
- **Strict-Transport-Security**: Enforces HTTPS by specifying the period in which the user agent should only access the server using secure connections (e.g., `Strict-Transport-Security: max-age=31536000`).

### T
- **TE**: Indicates what transfer encodings the client is willing to accept (e.g., `TE: trailers, deflate`).
- **Transfer-Encoding**: Specifies the form of encoding used to safely transfer the payload body to the user (e.g., `Transfer-Encoding: chunked`).

### U
- **Upgrade**: Requests to upgrade to a different protocol (e.g., `Upgrade: HTTP/2.0, SHTTP/1.3, IRC/6.9, RTA/x11`).
- **User-Agent**: Contains information about the user agent originating the request (e.g., `User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64)`).

### V
- **Via**: Informs the server of proxies through which the request was sent (e.g., `Via: 1.0 fred, 1.1 example.com (Apache/1.1)`).
- **Vary**: Informs the server to select the correct response based on the value of certain headers (e.g., `Vary: Accept-Encoding`).

### W
- **Warning**: Carries additional information about the status of a response (e.g., `Warning: 199 Miscellaneous warning`).
- **WWW-Authenticate**: Defines the authentication method that should be used to access a resource (e.g., `WWW-Authenticate: Basic realm="Access to the site"`).



### X
- **X-Content-Type-Options**: Indicates that the MIME types advertised in the `Content-Type` headers should not be changed or “sniffed” (e.g., `X-Content-Type-Options: nosniff`).
- **X-Frame-Options**: Controls whether a browser should be allowed to render a page in a frame (e.g., `X-Frame-Options: DENY`).
- **X-Powered-By**: Indicates technologies supporting the web application (e.g., `X-Powered-By: PHP/7.2.4`).

### Y
- **X-YouTube-Empowered**: Custom header sometimes used by YouTube APIs to track API access.

### Z
- **X-Zoo**: An example of a custom application-specific header.
