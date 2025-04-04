using UnityEngine;
using UnityEngine.SceneManagement; // Importowanie obs�ugi scen

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
