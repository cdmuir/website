---
# Leave the homepage title empty to use the site title
title: ""
date: 2025-08-30
type: landing

sections:
  - block: hero
    content:
      title: 'What we do'
      image:
        filename: 'QEPL_LOGO_FINAL_HORIZ_hi_screen.png'
      text: |
        <br>
        
        The Quantitative Evolutionary Physiology lab integrates experiments, comparative methods, and advanced quantitative tools to study physiological adaptation using plants as model systems. 
  
        Please [contact me](mailto:cdmuir@wisc.edu) if you would like to collaborate or join the lab as an undergraduate researcher, graduate student, or postdoc.

  - block: collection
    content:
      title: Latest Publications
      text: ""
      count: 5
      filters:
        folders:
          - publication
        publication_type: 'article'
    design:
      view: citation
      columns: '1'
      
  - block: markdown
    content:
      title:
      subtitle:
      text: |
        {{% cta cta_link="./people/" cta_text="Meet the team →" %}}
    design:
      columns: '1'
---
