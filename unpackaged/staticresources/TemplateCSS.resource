/* ==========================================================================
   Custom styles
   ========================================================================== */
html,body {
    min-height: 100%;
    width: 100%;
}
 
#main {
    margin-top: 72px;

    margin-bottom: 60px;
    padding-bottom: 3em;
}

.navbar-inverse {
  background-color: #005a87;
}

@media only screen and (min-width: 768px) {
  .navbar-inverse {
    min-height: 72px;
  }
}

.btn-next:before {
    content: 'xxx';
}

.btn-next:after {
    content:"\f061";    
	font-family: FontAwesome;
}

.errorMsg {color: #ea2f10; }
.navbar-brand {
    
    font-size: 1.25em;
    line-height: 1.25em;
    height:auto;
    width: 100%;
    text-align:center;
    padding: 8px;
}

@media only screen and (max-width: 480px) {
	.navbar-brand.hidden-xs { display: none; }
}

.navbar-brand > img {
    margin: 0 auto;
    max-height: 40px;
}

.navbar-brand ~ .navbar-brand {
    padding:  0 8px 8px;
}
 @media only screen and (min-width: 768px) {
    .navbar-brand { 
        font-size: 2em;
        line-height:1.25em;
        text-align:left;
    	width: auto; 
    }
    .navbar-brand > img {
        margin: 0;
        max-height: 50px;
    }
        
    .navbar-brand ~ .navbar-brand {
        padding: 16px;
    }
}
 @media only screen and (min-width: 990px) {
    .navbar-brand { 
        font-size: 2em;
        line-height:1.25em;
        text-align:left;
    	width: auto;
    }
    .navbar-brand > img {
        margin: 0;
    }
}
.text-uppercase {
    text-transform: uppercase;
}


/* Tooltip */
div.tooltip-inner {
    max-width: 320px;
}

/* */
.lead-nomargin {margin:0}
.margin-three-em {
    margin:4em 0;
}
.half-window-tall{
    min-height: 20vh;
}
.checkbox-label {
    cursor: pointer;
    font-size:16px;

}
.checkbox-label .fa.fa-question-circle{ font-size: 1.25em;line-height: 1em; }

.img-responsive{
    padding:5px;
}
/* Steps
-------------------------------------------------- */
.bs-wizard { margin: 1.5em 0; padding: 0 0 10px 0;}
.bs-wizard > .bs-wizard-step {padding: 0; position: relative;}
.bs-wizard > .bs-wizard-step + .bs-wizard-step {}
.bs-wizard > .bs-wizard-step .bs-wizard-stepnum {color: #595959; font-size: 16px; margin-bottom: 5px;}
.bs-wizard > .bs-wizard-step.active >  .bs-wizard-stepnum { font-weight: bold; }
.bs-wizard > .bs-wizard-step .bs-wizard-info {color: #999; font-size: 14px;}
.bs-wizard > .bs-wizard-step > .bs-wizard-dot {position: absolute; width: 30px; height: 30px; display: block; background: #fbe8aa; top: 45px; left: 50%; margin-top: -15px; margin-left: -15px; border-radius: 50%;} 
.bs-wizard > .bs-wizard-step > .bs-wizard-dot:after {content: ' '; width: 14px; height: 14px; background: #005a87; border-radius: 50px; position: absolute; top: 8px; left: 8px; } 
.bs-wizard > .bs-wizard-step > .progress {position: relative; border-radius: 0px; height: 8px; box-shadow: none; margin: 20px 0;}
.bs-wizard > .bs-wizard-step > .progress > .progress-bar {width:0px; box-shadow: none; background: #005a87;}
.bs-wizard > .bs-wizard-step.complete > .progress > .progress-bar {width:100%;}
.bs-wizard > .bs-wizard-step.active > .progress > .progress-bar {width:50%;}
.bs-wizard > .bs-wizard-step:first-child.active > .progress > .progress-bar {width:0%;}
.bs-wizard > .bs-wizard-step:last-child.active > .progress > .progress-bar {width: 100%;}
.bs-wizard > .bs-wizard-step.disabled > .bs-wizard-dot {background-color: #f5f5f5;}
.bs-wizard > .bs-wizard-step.disabled > .bs-wizard-dot:after {opacity: 0;}
.bs-wizard > .bs-wizard-step:first-child  > .progress {left: 50%; width: 50%;}
.bs-wizard > .bs-wizard-step:last-child  > .progress {width: 50%;}
.bs-wizard > .bs-wizard-step.disabled a.bs-wizard-dot{ pointer-events: none; }
/*END Form Wizard*/


/* File Upload Field Button 
-------------------------------------------------- */

.btn-file {
    position: relative;
    overflow: hidden;
}
.btn-file input[type=file] {
    position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: block;
}


/* Sticky footer styles
-------------------------------------------------- */
html {
  position: relative;
  min-height: 100%;
}
body {
  /* Margin bottom by footer height */
  margin-bottom: 60px;
}


.footer {
  font-size: 1.33em;
  padding:1em 0;
  position: absolute;
  bottom: 0;
    left:0;
  width: 100%;
  /* Set the fixed height of the footer here */
  height: 60px;
  background-color: #f5f5f5;
}
input[type="checkbox"]{
   -ms-transform: scale(1.5); /* IE */
  -moz-transform: scale(1.5); /* FF */
  -webkit-transform: scale(1.5); /* Safari and Chrome */
  -o-transform: scale(1.5); /* Opera */
  padding: 10px;
}
.CAPTCHAHeader{
    font-size: 1.33em;
}

 