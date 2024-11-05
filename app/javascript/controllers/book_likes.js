document.addEventListener('DOMContentLoaded', () => {
    const likeButtons = document.querySelectorAll('.like-button');

    likeButtons.forEach(button => {
        button.addEventListener('click', async (event) => {
            const bookId = button.getAttribute('data-book-id');
            const heartIcon = button.querySelector('.heart-icon');

            try {
                let response;

                if (heartIcon.classList.contains('fa-heart')) {
                    // Unlike the book
                    response = await fetch(`/likes`, {
                        method: 'DELETE',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        },
                        body: JSON.stringify({ book_id: bookId })
                    });
                } else {
                    // Like the book
                    response = await fetch(`/likes`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                        },
                        body: JSON.stringify({ book_id: bookId })
                    });
                }

                if (response.ok) {
                    heartIcon.classList.toggle('fa-heart'); // Toggle filled heart
                    heartIcon.classList.toggle('fa-heart-o'); // Toggle unfilled heart
                } else {
                    console.error('Failed to toggle like for the book.');
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
    });
});