using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class UI : MonoBehaviour
{
    [SerializeField] TMP_Text textCoinCountbbbbb;
    private int coinCount = 0;

    private void OnEnable()
    {
        CoinCollector.OnAnyCoinCollected += CountCoin;

    }

    private void OnDisable()
    {
        CoinCollector.OnAnyCoinCollected -= CountCoin;
    }

    private void CountCoin()
    {
        coinCount++;
        textCoinCountbbbbb.text = $": {coinCount}";
    }
}
