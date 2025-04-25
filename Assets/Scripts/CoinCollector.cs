using System;
using UnityEngine;

public class CoinCollector : MonoBehaviour
{
    public static Action OnAnyCoinCollected = delegate { };
    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Coin"))
        {
            OnAnyCoinCollected.Invoke();
            Destroy(other.gameObject); // Usuniêcie monety
        }
    }

}
