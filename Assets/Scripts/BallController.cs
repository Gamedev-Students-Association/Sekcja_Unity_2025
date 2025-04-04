using UnityEngine;

public class BallController : MonoBehaviour
{
    public float moveSpeed = 10f;  // Szybko�� poruszania
    public float jumpForce = 5f;   // Si�a skoku

    private Rigidbody rb;
    private bool isGrounded;       // Flaga sprawdzaj�ca, czy kulka jest na ziemi

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        // Sterowanie ruchem
        float moveX = Input.GetAxis("Horizontal");
        float moveZ = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(moveX, 0.0f, moveZ);
        rb.AddForce(movement * moveSpeed);

        // Skok na spacj�, tylko gdy kulka jest na ziemi
        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rb.AddForce(Vector3.up * jumpForce, ForceMode.Impulse);
            isGrounded = false; // Kulka nie jest ju� na ziemi
        }
    }

    // Sprawdzanie, czy kulka dotyka pod�o�a
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Ground"))
        {
            isGrounded = true;
        }
    }
}
