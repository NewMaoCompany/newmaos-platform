const fetch = require('node-fetch');
fetch('https://newmaos.com/api/questions?limit=1000')
  .then(res => res.json())
  .then(allQuestions => {
      // Simulate user state
      const user = { currentCourse: 'AB' };
      const topicParam = 'Both_Limits';
      const cleanTopic = 'Limits';
      const subTopicId = '1.1';
      
      const combined = allQuestions; // Mock unique logic
      console.log('Total questions:', combined.length);
      
      let filtered = combined.filter(q => {
            const isCourseMatch = user.currentCourse === 'BC' || q.course === user.currentCourse || q.course === 'Both';
            const qBase = q.topic && q.topic.includes('_') ? q.topic.split('_')[1] : q.topic;
            const isTopicMatch = q.topic === topicParam || q.topicId === topicParam || q.topic === cleanTopic || qBase === cleanTopic || (q.topic === 'Infinite Sequences and Series' && topicParam === 'BC_Series');
            const isStatusValid = q.status === 'published' || !q.status || q.status === 'draft';
            return isCourseMatch && isTopicMatch && isStatusValid;
        });
        
      console.log('After course/topic match:', filtered.length);
      
      if (filtered.length > 0) {
          console.log('Sample course:', filtered[0].course);
          console.log('Sample subTopicId field:', filtered[0].subTopicId !== undefined ? 'subTopicId' : (filtered[0].sub_topic_id !== undefined ? 'sub_topic_id' : 'none'));
      }
      
      if (subTopicId) {
          const realSubTopicId = subTopicId.replace('_review', '');
          filtered = filtered.filter(q => q.subTopicId === realSubTopicId);
      }
      
      console.log('Final filtered length:', filtered.length);
      
  })
  .catch(err => console.error(err));
