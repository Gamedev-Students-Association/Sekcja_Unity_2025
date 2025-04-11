using UnityEditor.Animations;
using UnityEngine;

public class SwapAnimation : MonoBehaviour
{

    [SerializeField] Animator animator;
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.L))
        {
            if (animator != null)
            {
                animator.SetTrigger("SwapAnimation");
            }
        }
    }
}
