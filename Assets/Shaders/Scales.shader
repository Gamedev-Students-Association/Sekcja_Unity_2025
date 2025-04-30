Shader "Example/URPUnlitShaderBasic"
{
    Properties
    {   
        colorOne("Color One", Color) = (1,1,1,1)
        colorTwo("Color Two", Color) = (1,1,1,1)
        squareScale("square Scale", vector) = (1,1,1,1)
        HexagonRatio("Hexagon Ratio", Range(0, 1)) = 0.5
        GradientHalo ("GradientHalo", Range(0, 1)) = 0
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
            vector squareScale;
            float HexagonRatio;
            float GradientHalo;

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

            float square(float2 position) {
                float result = 0;

                position = abs(position);
                result = max(position.x, position.y) - 1;
                return result;
                //python srajton
            }

            float diamond(float2 position)
            {
                float result = 0;
                position = abs(position);
                result = position.x + position.y;
                return result;
            }

            float enlongedDiamond(float2 pos, float height)
            {
                float res = 0;
                pos = abs(pos);
                if (pos.y < height) //main enlonged body
                {
                    res = pos.x;
                }
                else
                {
                    res = pos.x + max(0, pos.y - height) / (1 - height) / 2;
                }
                res -= 1;
                return res;
            }

            /*
            float2 pointy_hex_corner(center, size, i)
            {
                float angle_deg = 60 * i - 30°
                float angle_rad = PI / 180 * angle_deg
                return Point(center.x + size * cos(angle_rad),
                        center.y + size * sin(angle_rad))
            }
            */
                

            half4 frag(Varyings IN) : SV_Target
            {
                float4 color = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, IN.uv);
                float2 uv = IN.uv;

                float2 pos = uv;
                float2 chunkId = floor(pos * squareScale.xy);
                //*
                if (chunkId.y % 2 == 1)
                {
                    pos.x += 1 / squareScale.x / 2;
                }
                //*/

                float2 innerPos = (pos * squareScale.xy) % float2(1, 1);
                innerPos -= float2(0.5, 0.5);
                innerPos *= 2;

                //chunk combination
                //float chunk
                float2 neighbourChunkShift = float2(max(-1, sign(innerPos.x)), sign(innerPos.y));
                neighbourChunkShift *= 2;
                neighbourChunkShift.x -= 1 * sign(innerPos.x);

                //creating dumbass hexagon
                color = float4(innerPos.x, innerPos.y, 0, 1);
                //*
                float scale = enlongedDiamond(innerPos, 0.5);
                if (scale < 0) //main square
                {
                }
                else //not hitted, neighbour chunk
                {
                    //change inner pos BASED on neighbour chunk
                    innerPos -= neighbourChunkShift;
                    scale = enlongedDiamond(innerPos, HexagonRatio);
                }
                //*/

                /*
                if (innerPos.x > 0.9 || innerPos.y > 0.9)
                {
                    color = float4(0, 0, 0, 1);
                }
                */


                color = lerp(colorOne, colorTwo, max(0, (-scale - GradientHalo) / GradientHalo));

                return color;
            }
            ENDHLSL
        }
    }
}