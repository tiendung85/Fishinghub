document.addEventListener('DOMContentLoaded', function() {
    const tabButtons = document.querySelectorAll('.tab-button');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            const tab = this.getAttribute('data-tab');
            
            // Navigate to appropriate page based on tab
            switch(tab) {
                case 'post-achievement':
                    window.location.href = 'CreateAchievemnt.jsp';
                    break;
                case 'my-achievements':
                    window.location.href = 'Achievement.jsp';
                    break;
                case 'leaderboard':
                    window.location.href = 'Rating.jsp';
                    break;
            }
        });
    });
});