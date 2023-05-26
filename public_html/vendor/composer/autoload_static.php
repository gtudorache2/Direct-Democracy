<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitc7117c0ea251224c1b38abb60bc2bde8
{
    public static $prefixLengthsPsr4 = array (
        'C' => 
        array (
            'Cloutier\\PhpIpfsApi\\' => 20,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Cloutier\\PhpIpfsApi\\' => 
        array (
            0 => __DIR__ . '/..' . '/cloutier/php-ipfs-api/src',
        ),
    );

    public static $classMap = array (
        'Composer\\InstalledVersions' => __DIR__ . '/..' . '/composer/InstalledVersions.php',
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitc7117c0ea251224c1b38abb60bc2bde8::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitc7117c0ea251224c1b38abb60bc2bde8::$prefixDirsPsr4;
            $loader->classMap = ComposerStaticInitc7117c0ea251224c1b38abb60bc2bde8::$classMap;

        }, null, ClassLoader::class);
    }
}