Shader "Example/URPUnlitShaderBasic"
{
    Properties
    {   
        colorOne("Color One", Color) = (1,1,1,1)
        colorTwo("Color Two", Color) = (1,1,1,1)
        squereScale("Squere Scale", vector) = (1,1,1,1)
        _BaseMap("Python ssie Base Map", 2D) = "green"
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalRenderPipeline" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"   

            vector colorOne;
            vector colorTwo;  
            vector squereScale;

            struct Attributes
            {
                float4 positionOS   : POSITION; 
                float2 uv           : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS  : SV_POSITION;
                float2 uv           : TEXCOORD0;
            };     
            TEXTURE2D(_BaseMap);
            SAMPLER(sampler_BaseMap);

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseMap_ST;
            CBUFFER_END

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = TRANSFORM_TEX(IN.uv, _BaseMap);
                return OUT;
            }

            float squere(float2 position) {
                float result = 0;
                /*
                if(abs(position.x) < 0.5 || abs(position.y) < 0.5) {
                    result = -1;
                }
                else {
                    result = 1;
                }
                */
                position = abs(position);
                result = max(position.x, position.y) - 1;
                return result;
                //python srajton
            }

            half4 frag(Varyings IN) : SV_Target
            {
                float4 color = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, IN.uv);
                float2 uv = IN.uv;
                uv -= float2(0.5, 0.5);
                uv *= squereScale.xy;
                //return float4(uv.x, uv.y, 0, 0);
                if(squere(uv) < 0) {
                    color = float4(1, 1, 1, 1);
                }
                else {
                    color = float4(0.65, 0.31, 0.12, 1.0);
                }
                return color;
            }
            ENDHLSL
        }
    }
}