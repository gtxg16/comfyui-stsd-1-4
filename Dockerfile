# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# If your workflow needs custom nodes, add them here. ResolutionSelector and
# ComfySwitchNode are NOT core ComfyUI — check ComfyUI Manager locally for the
# pack names and uncomment. Node 49 (ResolutionSelector) can be deleted instead
# if you drive width/height from SillyTavern.
# RUN comfy-node-install <pack-name> <pack-name>

# --- diffusion model (workflow node 56) ---
RUN for i in 1 2 3 4 5; do \
      comfy model download \
        --url 'https://huggingface.co/Comfy-Org/Krea-2/resolve/main/diffusion_models/krea2_turbo_fp8_scaled.safetensors' \
        --relative-path models/diffusion_models \
        --filename 'krea2_turbo_fp8_scaled.safetensors' \
      && break || { [ "$i" = 5 ] && exit 1; sleep $((i * 15)); }; \
    done

# --- vae (workflow node 57) ---
RUN for i in 1 2 3 4 5; do \
      comfy model download \
        --url 'https://huggingface.co/QuantStack/Qwen-Image-Edit-GGUF/resolve/5cf642dd2b94af2a558ec06a9dde255c673e1fdf/VAE/Qwen_Image-VAE.safetensors' \
        --relative-path models/vae \
        --filename 'Qwen_Image-VAE.safetensors' \
      && break || { [ "$i" = 5 ] && exit 1; sleep $((i * 15)); }; \
    done

# --- text encoder / clip (workflow node 63) ---
RUN for i in 1 2 3 4 5; do \
      comfy model download \
        --url 'https://huggingface.co/John2386/fullgreed/resolve/515e482855cd0b08eb5a4c5ecb620247ceb21bdd/qwen3vl_4b_bf16.safetensors' \
        --relative-path models/text_encoders \
        --filename 'qwen3vl_4b_bf16.safetensors' \
      && break || { [ "$i" = 5 ] && exit 1; sleep $((i * 15)); }; \
    done

# --- loras (workflow nodes 64 and 65) ---
RUN for i in 1 2 3 4 5; do \
      comfy model download \
        --url 'https://huggingface.co/yufusoft/realism_engine_krea2_v3.1/resolve/main/realism_engine_krea2_v3.1.safetensors' \
        --relative-path models/loras \
        --filename 'realism_engine_krea2_v3.1.safetensors' \
      && break || { [ "$i" = 5 ] && exit 1; sleep $((i * 15)); }; \
    done

RUN for i in 1 2 3 4 5; do \
      comfy model download \
        --url 'https://huggingface.co/mpasila/Krea-2-LoRAs/resolve/main/Krea2_TextFusion_Refusal_Reduction.safetensors' \
        --relative-path models/loras \
        --filename 'Krea2_TextFusion_Refusal_Reduction.safetensors' \
      && break || { [ "$i" = 5 ] && exit 1; sleep $((i * 15)); }; \
    done
