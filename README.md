# Hugo Build Action

A Github Action to build [`hugo`](https://gohugo.io/) static sites.

## Environment Variables

- GITHUB_EMAIL: git use email
- GITHUB_USERNAME: git use username
- HUGO_ARGS: hugo build args

## How to Use

```
    - name: Hugo Build Action
      uses: x-actions/hugo@release/v1
      env:
        GITHUB_EMAIL: "me@xiexianbin.cn"
        GITHUB_USERNAME: "xiexianbin"
        HUGO_ARGS: "--config config.yaml"
```
