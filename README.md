# Github Action for Hugo

A Github Action to build [`hugo`](https://gohugo.io/) static sites.

## Environment Variables

- GITHUB_EMAIL: git use email
- GITHUB_USERNAME: git use username
- HUGO_THEME_URL: hugo theme url[not use]

## How to Use

```
    - name: build hugo
      uses: x-actions/hugo@master
      env:
        GITHUB_EMAIL: "me@xiexianbin.cn"
        GITHUB_USERNAME: "xiexianbin"
        # HUGO_THEME_URL: "https://xiexianbin:${{ secrets.GitHub_PAT }}@github.com/xiexianbin/hugo-bootstrap-x.git"
```
