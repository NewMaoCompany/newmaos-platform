const fetch = require('node-fetch');
fetch('https://newmaos.com/api/questions?limit=1000')
  .then(res => res.json())
  .then(data => {
      const limitsQs = data.filter(q => q.topic === 'Both_Limits' || q.topicId === 'Both_Limits');
      console.log(`Found ${limitsQs.length} questions for Both_Limits`);
      const subtopics = new Set(limitsQs.map(q => q.subTopicId || q.sub_topic_id));
      console.log('Available subTopicIds:', Array.from(subtopics));
      
      const onePointOneQs = limitsQs.filter(q => (q.subTopicId || q.sub_topic_id) === '1.1');
      console.log(`Questions exactly matching '1.1': ${onePointOneQs.length}`);
      
      if (limitsQs.length > 0) {
          console.log('Sample question subTopicId typeof:', typeof (limitsQs[0].subTopicId || limitsQs[0].sub_topic_id));
          console.log('Sample question exact subTopicId:', JSON.stringify(limitsQs[0].subTopicId || limitsQs[0].sub_topic_id));
      }
  })
  .catch(err => console.error(err));
