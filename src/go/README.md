
# Go Installation (go)

This feature installs the latest stable version of Go from go.dev.

## Example Usage

```json
"features": {
    "ghcr.io/john-h3/devc_features/go:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| mirror | Select the mirror to use: USTC, NJU, or Aliyun. | string | ustc |
| arch | Select the architecture to use: amd64 or arm64. | string | amd64 |
| version | Specify the Go version to install (e.g., '1.23.3'). | string | 1.23.3 |

## Customizations

### VS Code Extensions

- `golang.Go`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/john-h3/devc_features/blob/main/src/go/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
