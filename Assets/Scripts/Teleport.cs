using UnityEngine;
using UnityEngine.SceneManagement; // Importowanie obs³ugi scen

public class Teleport : MonoBehaviour
{
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player")) // Sprawdzenie czy obiekt to gracz
        {
            SceneManager.LoadScene("Scene nr 2");
        }
    }
}
