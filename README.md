# LAS to 3D tiles Converter

## Prerequisites

- Container runtime environment
  - Docker, OrbStack...

## Getting Started

1. Set Execution Permission

```
chmod +x build.sh
```

2. Run the conversion process
   Execute the script with parameters:

```
./build.sh [PATH_TO_LAS_FILES_DIRECTORY] [CRS]
```

Example:

```
./build.sh ./las_files EPSG:6676
```
