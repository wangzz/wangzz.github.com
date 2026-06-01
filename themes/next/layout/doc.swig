<!DOCTYPE html>
<html lang="{{ config.language }}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{% if page.title %}{{ page.title }} | {% endif %}{{ config.title }}</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      max-width: 800px;
      margin: 0 auto;
      padding: 40px 20px;
      line-height: 1.8;
      color: #333;
    }
    h1, h2, h3, h4, h5, h6 {
      margin-top: 1.5em;
      margin-bottom: 0.5em;
    }
    a {
      color: #0594cb;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    code {
      background: #f5f5f5;
      padding: 2px 6px;
      border-radius: 3px;
      font-size: 0.9em;
    }
    pre {
      background: #f5f5f5;
      padding: 16px;
      border-radius: 6px;
      overflow-x: auto;
    }
    pre code {
      padding: 0;
      background: none;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      margin: 1em 0;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 8px 12px;
    }
    th {
      background: #f5f5f5;
    }
    blockquote {
      border-left: 4px solid #ddd;
      padding-left: 16px;
      margin: 1em 0;
      color: #666;
    }
    img {
      max-width: 100%;
      height: auto;
    }
  </style>
</head>
<body>
  {{ page.content }}
</body>
</html>
