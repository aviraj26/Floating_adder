<h1 align="center">Single Precision Floating Point Adder (IEEE 754)</h1>

<p align="center">
  <b>Verilog implementation of a 32-bit floating point adder following IEEE 754 standard</b><br>
  Designed for digital systems and hardware design practice.
</p>

<hr>

<h2>📌 Overview</h2>

<p>
This project implements a <b>Single Precision (32-bit) Floating Point Adder</b> in Verilog based on the IEEE 754 standard.
It performs addition of two floating point numbers by handling normalization, alignment, rounding, and special cases.
</p>

<hr>

<h2>🧠 IEEE 754 Single Precision Format</h2>

<table>
  <tr>
    <th>Field</th>
    <th>Bits</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>Sign</td>
    <td>1</td>
    <td>Represents positive or negative number</td>
  </tr>
  <tr>
    <td>Exponent</td>
    <td>8</td>
    <td>Biased exponent (Bias = 127)</td>
  </tr>
  <tr>
    <td>Mantissa</td>
    <td>23</td>
    <td>Fractional part (implicit leading 1)</td>
  </tr>
</table>

<hr>

<h2>⚙️ Working Principle</h2>

<ol>
  <li><b>Decompose Inputs</b> → Extract sign, exponent, and mantissa</li>
  <li><b>Align Exponents</b> → Shift smaller mantissa</li>
  <li><b>Perform Addition/Subtraction</b> → Based on signs</li>
  <li><b>Normalize Result</b> → Adjust mantissa and exponent</li>
  <li><b>Round Result</b> → IEEE 754 rounding</li>
  <li><b>Handle Special Cases</b> → NaN, Infinity, Zero</li>
</ol>

<hr>

<h2>📂 Project Structure</h2>

<pre>
.
├── src/
    ├── adder.v
    ├── comparator.v
    ├── controller.v
    ├── int_adder.v
    ├── normalizer.v
    └── shifter.v
</pre>

<hr>

<h2>🚀 Features</h2>

<ul>
  <li>✔ IEEE 754 compliant (Single Precision)</li>
  <li>✔ Handles normalization and rounding</li>
  <li>✔ Supports positive and negative numbers</li>
  <li>✔ Modular Verilog design</li>
  <li>✔ Testbench included</li>
</ul>


<h2>⚠️ Special Cases Handled</h2>

<ul>
  <li>Zero (+0, -0)</li>
  <li>Infinity (+∞, -∞)</li>
  <li>NaN (Not a Number)</li>
</ul>

<hr>
