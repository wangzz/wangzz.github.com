const fs = require('fs');
const path = require('path');

function ensureDocLayout(dir) {
  const files = fs.readdirSync(dir);
  files.forEach(file => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      ensureDocLayout(filePath);
    } else if (file.endsWith('.md')) {
      let content = fs.readFileSync(filePath, 'utf8');
      if (!content.includes('layout: doc')) {
        if (content.startsWith('---')) {
          content = content.replace(/^---\n/, '---\nlayout: doc\n');
        } else {
          content = '---\nlayout: doc\n---\n' + content;
        }
        fs.writeFileSync(filePath, content, 'utf8');
        console.log('Added layout: doc to ' + filePath);
      }
    }
  });
}

const docDir = path.join(hexo.source_dir, 'doc');
if (fs.existsSync(docDir)) {
  ensureDocLayout(docDir);
}
