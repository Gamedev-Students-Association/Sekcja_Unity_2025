using UnityEngine;

public class CoinRotation : MonoBehaviour
{
    public float rotationSpeed = 100f;  // Szybkoœæ obracania (mo¿esz dostosowaæ w Inspectorze)

    void Update()
    {
        // Obracanie wokó³ osi Y (pionowej)
        transform.Rotate(rotationSpeed * Time.deltaTime, 0f, 0f);
    }
}
