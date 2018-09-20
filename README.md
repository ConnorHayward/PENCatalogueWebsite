# PENCatalogue.jl

# make_batch()

Function to create a new batch, for addition to the catalogue.

This document will cover possible prompts and responses in the format:
### Prompt
Response 1 / Response 2

### Type:
tile / raw_pen / granulate.

## Type = Granulate:

###  Granulate Type:
PEN8065 / PEN8050

### Manufacturer
Teijin

### UUID
Scan barcode

### Batch Number:
Batch number on the bag of Granulate

## Type = raw_pen

### Mass
Mass produced

### Creation Date
dd/mm/yyyy

### Manufacturer
Oakridge / NUVIA

### Batch Number
Reference number

### UUID
Scan barcode

# make_tile
To create an individual instance of a batch, used in measurements.

### Type

tile / capsule

### Producer
TuD / ICT / NUVIA

### Material
PEN8065 / PEN8050 / PS / BC408

### Run Reference
Reference number for batch. This will be updated to allow automation.

### Geometry
Standard / capsule

### Size
Dimensions

### Tile Number
Reference number for tile
