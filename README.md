# Qwen3.5 2B local WASM chat

This is a static browser app using ONNX Runtime Web's **WASM** execution provider. The checked-in app no longer points at the unrelated LLaMA tokenizer or assumes a hand-picked KV-cache shape.

## Get the complete model

The ONNX model is too large for a practical source checkout and is excluded from Git. Run:

```bash
./download-model.sh
python3 -m http.server 8080
```

Then open `http://localhost:8080`. The downloader fetches the complete `onnx-community/Qwen3.5-2B-ONNX` repository, including `onnx/`, tokenizer files, config, and chat template. This repository is the Transformers.js-compatible ONNX export; Qwen3.5 is a hybrid model, so the old generic decoder/KV assumptions are not valid.

The app also supports selecting `model.onnx` and its matching external-data file manually. Keep the ONNX and `.onnx_data` file in the same directory.

## Research basis

- Hugging Face model files: https://huggingface.co/onnx-community/Qwen3.5-2B-ONNX/tree/main
- Transformers.js ONNX model convention: https://huggingface.co/docs/transformers.js/en/guides/convert
- ONNX Runtime Web WASM execution provider: https://onnxruntime.ai/docs/get-started/with-javascript.html

The app deliberately defaults to WASM for compatibility. WebGPU is optional and can be enabled in the source only after validating the model's operators on the target browser.

## GitHub Pages behavior

There is no upload step and no localhost/backend dependency. `index.html` automatically downloads the verified `decoder_model_merged_q4f16.onnx` plus its matching 1.09 GB external-data shard from the ONNX Community Hugging Face repository, then runs it through WASM in the visitor's browser. GitHub Pages serves only the static app; the model is cached by the browser after its first download.
