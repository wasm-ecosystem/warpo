import { reportConfig } from "../index.js";
import { FileCoverageResult, Rate, OrganizationName, Repository } from "../../interface.js";

function getLevel(rate: Rate): "high" | "medium" | "low" {
  const r = rate.getRate();
  if (r > reportConfig.warningLimit) {
    return "high";
  } else if (r > reportConfig.errorLimit) {
    return "medium";
  } else {
    return "low";
  }
}

function generateFileInfo(fileInfo: FileCoverageResult): string {
  const {
    filename,
    statementCoverageRate: statement,
    branchCoverageRate: branch,
    functionCoverageRate: func,
    lineCoverageRate: line,
  } = fileInfo;
  return `
<tr>
  <td class="file ${getLevel(statement)}" data-value="${filename}">
    <a href="${filename}.html">${filename}</a>
  </td>
  <td data-value="${statement.getRate()}" class="pic ${getLevel(statement)}">
    <div class="chart"><div class="cover-fill cover-full" style="width: ${statement.getRate()}%"></div>
  </td>
  <td data-value="${statement.getRate()}" class="pct ${getLevel(statement)}">${statement.getRate()}%</td>
  <td data-value="${statement.total}" class="abs ${getLevel(statement)}">${statement.toString()}</td>
  <td data-value="${branch.getRate()}" class="pct ${getLevel(branch)}">${branch.getRate()}%</td>
  <td data-value="${branch.total}" class="abs ${getLevel(branch)}">${branch.toString()}</td>
  <td data-value="${func.getRate()}" class="pct ${getLevel(func)}">${func.getRate()}%</td>
  <td data-value="${func.total}" class="abs ${getLevel(func)}">${func.toString()}</td>
  <td data-value="${line.getRate()}" class="pct ${getLevel(line)}">${line.getRate()}%</td>
  <td data-value="${line.total}" class="abs ${getLevel(line)}">${line.toString()}</td>
</tr>
  `;
}

function generateFileInfos(filesInfo: FileCoverageResult[]): string {
  return filesInfo.map((v) => generateFileInfo(v)).join("\n");
}

export function generateFolderHtml(relativePathofRoot: string, filesInfo: FileCoverageResult[]): string {
  const statementCoverageRate: Rate = new Rate();
  const branchCoverageRate: Rate = new Rate();
  const functionCoverageRate: Rate = new Rate();
  const lineCoverageRate: Rate = new Rate();
  for (const fileinfo of filesInfo) {
    statementCoverageRate.used += fileinfo.statementCoverageRate.used;
    statementCoverageRate.total += fileinfo.statementCoverageRate.total;
    branchCoverageRate.used += fileinfo.branchCoverageRate.used;
    branchCoverageRate.total += fileinfo.branchCoverageRate.total;
    functionCoverageRate.used += fileinfo.functionCoverageRate.used;
    functionCoverageRate.total += fileinfo.functionCoverageRate.total;
    lineCoverageRate.used += fileinfo.lineCoverageRate.used;
    lineCoverageRate.total += fileinfo.lineCoverageRate.total;
  }

  return `

<!doctype html>
<html lang="en">

<head>
  <title>Code coverage report for tests</title>
  <meta charset="utf-8" />
  <link rel="stylesheet" href="${relativePathofRoot}/resource/prettify.css" />
  <link rel="stylesheet" href="${relativePathofRoot}/resource/base.css" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style type='text/css'>
    .coverage-summary .sorter {
        background-image: url(${relativePathofRoot}/resource/sort-arrow-sprite.png);
    }
  </style>
</head>
      
<body>
  <div class='wrapper'>
    <div class='pad1'>
      <h1><a href="${relativePathofRoot}/index.html">All files</a> tests</h1>
      <div class='clearfix'>
        <div class='fl pad1y space-right2'>
          <span class="strong">${statementCoverageRate.getRate()}% </span>
          <span class="quiet">Statements</span>
          <span class='fraction'>${statementCoverageRate.toString()}</span>
        </div>
            
        <div class='fl pad1y space-right2'>
          <span class="strong">${branchCoverageRate.getRate()}% </span>
          <span class="quiet">Branches</span>
          <span class='fraction'>${branchCoverageRate.toString()}</span>
        </div>
        
            
        <div class='fl pad1y space-right2'>
          <span class="strong">${functionCoverageRate.getRate()}% </span>
          <span class="quiet">Functions</span>
          <span class='fraction'>${functionCoverageRate.toString()}</span>
        </div>
        
        <div class='fl pad1y space-right2'>
          <span class="strong">${lineCoverageRate.getRate()}% </span>
          <span class="quiet">Lines</span>
          <span class='fraction'>${lineCoverageRate.toString()}</span>
        </div>
      </div>

      <p class="quiet">
          Press <em>n</em> or <em>j</em> to go to the next uncovered block, <em>b</em>, <em>p</em> or <em>k</em> for the previous block.
      </p>
    </div>

    <div class='status-line high'></div>
    <div class="pad1">
      <table class="coverage-summary">
        <thead>
          <tr>
            <th data-col="file" data-fmt="html" data-html="true" class="file">File</th>
            <th data-col="pic" data-type="number" data-fmt="html" data-html="true" class="pic"></th>
            <th data-col="statements" data-type="number" data-fmt="pct" class="pct">Statements</th>
            <th data-col="statements_raw" data-type="number" data-fmt="html" class="abs"></th>
            <th data-col="branches" data-type="number" data-fmt="pct" class="pct">Branches</th>
            <th data-col="branches_raw" data-type="number" data-fmt="html" class="abs"></th>
            <th data-col="functions" data-type="number" data-fmt="pct" class="pct">Functions</th>
            <th data-col="functions_raw" data-type="number" data-fmt="html" class="abs"></th>
            <th data-col="lines" data-type="number" data-fmt="pct" class="pct">Lines</th>
            <th data-col="lines_raw" data-type="number" data-fmt="html" class="abs"></th>
          </tr>
        </thead>

        <tbody>
          ${generateFileInfos(filesInfo)}
        </tbody>
      </table>
    </div>

    <div class='push'></div>
  </div>

  <div class="footer quiet pad2 space-top1 center small">
    Code coverage generated by 
    <a href="${Repository}" target="_blank">${OrganizationName}</a> 
    at ${new Date().toUTCString()}
  </div>
  
  </div>
  <script src="${relativePathofRoot}/resource/prettify.js"></script>
  <script>
    window.onload = function () {
      prettyPrint();
    };
  </script>
  <script src="${relativePathofRoot}/resource/sorter.js"></script>
  <script src="${relativePathofRoot}/resource/block-navigation.js"></script>
</body>

      `;
}
