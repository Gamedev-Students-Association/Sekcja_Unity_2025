using UnityEngine;

public class CoinRotation : MonoBehaviour
{
    public float rotationSpeed = 100f;  // Szybko�� obracania (mo�esz dostosowa� w Inspectorze)

    void Update()
    {
        // Obracanie wok� osi Y (pionowej)
        transform.Rotate(rotationSpeed * Time.deltaTime, 0f, 0f);
    }
}
